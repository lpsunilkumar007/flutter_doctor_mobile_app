
namespace Appointment.Core.Models;
public class Doctor : BaseEntity
{
    public string Firstname { get; set; }
    public string Lastname { get; set; }
    public string Specialization { get; set; }
    public string Schedule { get; set; }
}