using Appointment.Data;
using Appointment.Core.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Appointment.Service.Repositories;

public class GenericRepositoryAsync<T> : IGenericRepositoryAsync<T> where T : class
{
    private readonly AppointmentContext _dbContext;
    public GenericRepositoryAsync(AppointmentContext context)
    {
        _dbContext = context;
       
    }


    #region Add Entity
    /// <summary>
    /// Add Entity
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="entity"></param>
    /// <returns></returns>
    public async Task<T> AddAsync<T>(T entity) where T : class
    {
        _dbContext.ChangeTracker.AutoDetectChangesEnabled = true;

        await _dbContext.Set<T>().AddAsync(entity);

        _dbContext.ChangeTracker.AutoDetectChangesEnabled = false;

        await _dbContext.SaveChangesAsync();
        return entity;
    }
   
    #endregion

    #region Entity Actions
    public virtual async Task<T> GetByIdAsync(int id)
    {
        return await _dbContext.Set<T>().FindAsync(id);
    }

    public virtual async Task<T> GetByIdNoTrackAsync(int id)
    {
        var entity = await _dbContext.Set<T>().FindAsync(id);
        if (entity != null)
        {
            _dbContext.Entry(entity).State = EntityState.Detached;
        }
        return entity;
    }

    public async Task<IReadOnlyList<T>> GetPagedReponseAsync(int pageNumber, int pageSize)
    {
        return await _dbContext
            .Set<T>()
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .AsNoTracking()
            .ToListAsync();
    }
    public async Task UpdateAsync(T entity)
    {
        _dbContext.ChangeTracker.Clear();
        _dbContext.Entry(entity).State = EntityState.Modified;
        await _dbContext.SaveChangesAsync();


    }


    public async Task DeleteAsync(T entity)
    {
        _dbContext.Set<T>().Remove(entity);
        await _dbContext.SaveChangesAsync();
    }

    public async Task<IReadOnlyList<T>> GetAllAsync()
    {
        return await _dbContext
             .Set<T>()
             .ToListAsync();
    }

    public virtual async Task<IEnumerable<T>> AddRangeAsync(IEnumerable<T> entities, CancellationToken cancellationToken = default)
    {
        _dbContext.Set<T>().AddRange(entities);
        await SaveChangesAsync(cancellationToken);
        return entities;
    }

    public virtual async Task UpdateRangeAsync(IEnumerable<T> entities, CancellationToken cancellationToken = default)
    {
        _dbContext.ChangeTracker.Clear();
        _dbContext.Set<T>().UpdateRange(entities);
        await SaveChangesAsync(cancellationToken);
    }
    public virtual async Task DeleteRangeAsync(IEnumerable<T> entities, CancellationToken cancellationToken = default)
    {
        _dbContext.Set<T>().RemoveRange(entities);
        await SaveChangesAsync(cancellationToken);
    }

    public virtual async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        return await _dbContext.SaveChangesAsync(cancellationToken);
    }

    public virtual async Task<List<T>> ListAsync(CancellationToken cancellationToken = default)
    {
        return await _dbContext.Set<T>().ToListAsync(cancellationToken);
    }

    public virtual async Task<int> CountAsync(CancellationToken cancellationToken = default)
    {
        return await _dbContext.Set<T>().CountAsync(cancellationToken);
    }

    public virtual async Task<bool> AnyAsync(CancellationToken cancellationToken = default)
    {
        return await _dbContext.Set<T>().AnyAsync(cancellationToken);
    }
    #endregion



}