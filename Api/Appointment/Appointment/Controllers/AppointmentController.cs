using Appointment.Core.DTOs;
using Appointment.Core.Interfaces;
using Appointment.Core.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace Appointment.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController : ControllerBase
    {
        private readonly IAppointmentAsync _appointment;
        public AppointmentController(IAppointmentAsync appointment)
        {
            _appointment = appointment;
        }

        [HttpPost]
        public async Task<Core.Models.Appointment> Save(AppointmentDto appointmentDto)
        {
            appointmentDto.AppointmentDate = appointmentDto.AppointmentDate.Date;
            Core.Models.Appointment appointment = new Core.Models.Appointment();
            appointment.DoctorId = appointmentDto.DoctorId;
            appointment.PatientId = appointmentDto.PatientId;
            appointment.AppointmentDate = appointmentDto.AppointmentDate.Add(appointmentDto.AppointmentTime);
            appointment.Status = appointmentDto.Status;
                await _appointment.AddAsync(appointment);
            return appointment;
        }
        [HttpGet("doctor/{doctorId:int}/{selectedDate:DateTime}")]
        [HttpGet("pateint/{patientId:int}/{selectedDate:DateTime}")]
        public async Task<List<BookedAppointmentDto>> Get(int doctorId, int patientId, DateTime selectedDate)
        {
            var appoint = await _appointment.GetAppointmentByDoctorId(doctorId,patientId, selectedDate);
            List<BookedAppointmentDto> bookedAppointmentDto = new List<BookedAppointmentDto>();
            foreach(var tt in appoint)
            {
                var time = tt.AppointmentDate.ToString("HH:mm:ss");
                bookedAppointmentDto.Add(new BookedAppointmentDto
                {
                    PatientId= tt.PatientId,
                    DoctorId = tt.DoctorId,
                    SlotsTime = time,
                    CanBook=false
                });
            }
            return bookedAppointmentDto;
        }

        [HttpGet("doctor")]
        public async Task<List<DoctorDTO>> GetAllDoctor()
        {
            var doctor = await _appointment.GetAllDoctor();
            return doctor;
        }

        [HttpGet("doctor/{doctorId:int}")]
        public async Task<List<DoctorAppointmentDTO>> GetAllAppoinyment (int doctorId)
        {
            var appoint = await _appointment.GetAllAppointmentByDoctorId(doctorId);
            List<DoctorAppointmentDTO> doctorAppointmentDTO = new List<DoctorAppointmentDTO>();
            foreach (var tt in appoint)
            {
                if(tt.AppointmentDate.Date > DateTime.Now.Date)
                {
                    var time = tt.AppointmentDate.ToString("HH:mm");
                var date = tt.AppointmentDate.ToString("yyyy-MM-dd");
                doctorAppointmentDTO.Add(new DoctorAppointmentDTO
                {
                    Date = date,
                    Time = time,
                    AppointmentDate = tt.AppointmentDate,
                    PatientId = tt.PatientId,
                    DoctorId=tt.DoctorId,
                });
                }
                
            }
            return doctorAppointmentDTO;
        }        
    }
}
