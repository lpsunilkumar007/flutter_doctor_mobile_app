
using Appointment.Core.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appointment.Core.DTOs;

public class BookedAppointmentDto : BaseEntity
{
    public int PatientId { get; set; }
    public int DoctorId { get; set; }
    public string SlotsTime { get; set; }
    public bool CanBook { get; set; }
   
}
