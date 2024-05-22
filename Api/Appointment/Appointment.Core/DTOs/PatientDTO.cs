
using Appointment.Core.Models;

namespace Appointment.Core.DTOs;
public class PatientDTO : BaseEntity
{
    public int DoctorId { get; set; }
    public string Firstname { get; set; }
    public string Lastname { get; set; }
    public DateTime Dob { get; set; }
    public string Gender { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string InsuranceInfo { get; set; }
}