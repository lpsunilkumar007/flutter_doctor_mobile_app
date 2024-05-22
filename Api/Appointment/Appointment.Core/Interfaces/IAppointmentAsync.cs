
using Appointment.Core.DTOs;

namespace Appointment.Core.Interfaces
{
   public interface  IAppointmentAsync : IGenericRepositoryAsync<Models.Appointment>
    {
        Task<bool> GetAppointmentByDate(DateTime date);
        Task<List<Core.Models.Appointment>> GetAppointmentByDoctorId(int doctorID, int patientId, DateTime dateTime);
        Task<List<DoctorDTO>> GetAllDoctor();
        Task<List<Core.Models.Appointment>> GetAllAppointmentByDoctorId(int doctorID);
        Task<Core.Models.Patient> GetPatientById(int patientID);
    }
}
