
using Appointment.Core.Models;

namespace Appointment.Core.DTOs;
public class DoctorAppointmentDTO : BaseEntity
{
    public string? Date { get; set; }
    public string Time { get; set; }
    public int PatientId { get; set; }
    public int DoctorId { get; set; }
    public DateTime AppointmentDate { get; set; }
}