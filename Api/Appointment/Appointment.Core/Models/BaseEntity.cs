
using Appointment.Core.Interfaces;
using System.ComponentModel.DataAnnotations;

namespace Appointment.Core.Models;


[Serializable]
public abstract class BaseEntity : IID
{
    [Key]
    public int Id { get; set; }
}
