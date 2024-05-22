using Appointment.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace Appointment.Data;
public class AppointmentContext : DbContext
{
    public AppointmentContext(DbContextOptions options) : base(options)
    {
    }
    public virtual DbSet<Core.Models.Appointment> Appointments { get; set; }
    public virtual DbSet<Billing> Billings { get; set; }
    public virtual DbSet<Doctor> Doctors { get; set; }
    public virtual DbSet<Patient> Patients { get; set; }
}
