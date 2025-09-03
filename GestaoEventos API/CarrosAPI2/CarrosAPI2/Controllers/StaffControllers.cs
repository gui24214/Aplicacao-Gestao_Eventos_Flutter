using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StaffController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Staff> espacos = new List<Staff>();

        public StaffController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/staff
        [HttpGet]
        public ActionResult<List<Staff>> Get()
        {
            return Ok(_context.Staff.ToList());
        }

        // GET: api/staff/{id}
        [HttpGet("{id}")]
        public ActionResult<Staff> Get(int id)
        {
            var staff = _context.Staff.Find(id);
            if (staff == null) return NotFound();

            return Ok(staff);
        }

        // POST: api/staff
        [HttpPost]
        public ActionResult Post(Staff novoStaff)
        {
            _context.Staff.Add(novoStaff);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoStaff.Id_Staff }, novoStaff);
        }

        // PUT: api/staff/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Staff staffAtualizado)
        {
            var staff = _context.Staff.Find(id);
            if (staff == null) return NotFound();

            staff.Id_Estatuto = staffAtualizado.Id_Estatuto;
            staff.Nome = staffAtualizado.Nome;
            staff.Id_Evento = staffAtualizado.Id_Evento;


            _context.SaveChanges();
            return NoContent();
        }

        // DELETE: api/staff/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var staff = _context.Staff.Find(id);
            if (staff == null) return NotFound();

            _context.Staff.Remove(staff);
            _context.SaveChanges();

            return NoContent();
        }
    }
}