
using Appointment.Core.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appointment.Core.DTOs;

public class AppointmentDto : BaseEntity
{
    public int PatientId { get; set; }
    public int DoctorId { get; set; }
    public DateTime AppointmentDate { get; set; }
    public TimeSpan AppointmentTime { get; set; }
    public string Status { get; set; }
}
