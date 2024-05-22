using Appointment.Core.DTOs;
using Appointment.Core.Interfaces;
using Appointment.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;
namespace Appointment.Service.Repositories;

public class AppointmentAsync : GenericRepositoryAsync<Core.Models.Appointment>, IAppointmentAsync
{
    private AppointmentContext _context;
    public AppointmentAsync(AppointmentContext context) : base(context)
    {
        _context = context;
    }
    public async Task<bool> GetAppointmentByDate(DateTime date)
    {
        var dd = _context.Appointments.Where(x => x.AppointmentDate == date).FirstOrDefault();
        return dd != null ? true : false;
    }
    public async Task<List<Core.Models.Appointment>> GetAppointmentByDoctorId(int doctorID, int patientId, DateTime dateTime)
    {
        if (doctorID > 0 || patientId > 0)
            return _context.Appointments.Where(x => (x.DoctorId == doctorID || x.PatientId == patientId) && x.AppointmentDate.Date == dateTime.Date).ToList();
        else
            return new List<Core.Models.Appointment>();
    }

    public async Task<List<DoctorDTO>> GetAllDoctor()
    {
        var doctor = (from dd in _context.Doctors
                      select new DoctorDTO
                      {
                          Id = dd.Id,
                          Firstname = dd.Firstname,
                          Lastname = dd.Lastname,
                          Specialization = dd.Specialization,
                          Schedule = dd.Schedule,
                      }).ToList();


        return doctor;
    }
    public async Task<List<Core.Models.Appointment>> GetAllAppointmentByDoctorId(int doctorID)
    {
        return _context.Appointments.Where(x => x.DoctorId == doctorID).OrderBy(x=>x.AppointmentDate).ToList();
    }

    public async Task<Core.Models.Patient> GetPatientById(int patientID)
    {

        var doctor = (from dd in _context.Appointments
                      join cc in _context.Patients on dd.PatientId equals cc.Id
                      where dd.DoctorId == patientID
                      select new DoctorDTO
                      {
                          //Id = dd.Id,
                          //Firstname = dd.Firstname,
                          //Lastname = dd.Lastname,
                          //Specialization = dd.Specialization,
                          //Schedule = dd.Schedule,
                      }).ToList();

        return _context.Patients.Where(x => x.Id == patientID).FirstOrDefault();
    }
}
