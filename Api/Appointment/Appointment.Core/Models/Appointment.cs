
using System.ComponentModel.DataAnnotations.Schema;

namespace Appointment.Core.Models;

public class Appointment : BaseEntity
{
    public int PatientId { get; set; }
    public int DoctorId { get; set; }
    public DateTime AppointmentDate { get; set; }
    public string Status { get; set; }
    [ForeignKey("PatientId")] public Patient Patient { get; set; }
    [ForeignKey("DoctorId")] public Doctor Doctor { get; set; }

}
