using Appointment.Core.Interfaces;
using Appointment.Data;
using Appointment.Service.Repositories;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

ConfigurationManager configuration = builder.Configuration;
builder.Services.AddDbContext<AppointmentContext>(options => options.UseSqlServer((configuration.GetConnectionString("AppointmentDB")), a => a.CommandTimeout(1200)));



builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

#region Services
builder.Services.AddScoped<IAppointmentAsync, AppointmentAsync>();
#endregion

var app = builder.Build();
#region Migration
using (var serviceScope = app.Services.CreateScope())
{
    var dbContext = serviceScope.ServiceProvider.GetRequiredService<AppointmentContext>();
    dbContext.Database.Migrate();
}
#endregion



// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
