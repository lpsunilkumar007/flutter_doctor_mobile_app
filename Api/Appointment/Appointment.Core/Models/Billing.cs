
using System.ComponentModel.DataAnnotations.Schema;

namespace Appointment.Core.Models;

public class Billing : BaseEntity
{
    public int PatientId { get; set; }
    public decimal Amount { get; set; }
    public DateTime BillingDate { get; set; }
    public string PaymentStatus { get; set; }
    [ForeignKey("PatientId")] public Patient Patient { get; set; }
}

