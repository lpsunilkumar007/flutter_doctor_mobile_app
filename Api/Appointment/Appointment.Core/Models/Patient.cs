
namespace Appointment.Core.Models;


public class Patient : BaseEntity
{
    public string Firstname { get; set; }
    public string Lastname { get; set; }
    public DateTime Dob { get; set; }
    public string Gender { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string InsuranceInfo { get; set; }

}