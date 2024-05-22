
using Appointment.Core.Models;

namespace Appointment.Core.DTOs;
public class DoctorDTO : BaseEntity
{
    public string Firstname { get; set; }
    public string Lastname { get; set; }
    public string Specialization { get; set; }
    public string Schedule { get; set; }
}