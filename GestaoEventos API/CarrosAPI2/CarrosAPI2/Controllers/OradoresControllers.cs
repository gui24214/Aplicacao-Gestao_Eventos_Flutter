using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OradoresController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Oradores> oradores = new List<Oradores>();

        public OradoresController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/oradores
        [HttpGet]
        public ActionResult<List<Oradores>> Get()
        {
            return Ok(_context.Oradores.ToList());
        }

        // GET: api/oradores/{id}
        [HttpGet("{id}")]
        public ActionResult<Oradores> Get(int id)
        {
            var orador = _context.Oradores.Find(id);
            if (orador == null) return NotFound();

            return Ok(orador);
        }

        // POST: api/oradores
        [HttpPost]
        public ActionResult Post(Oradores novoOrador)
        {
            _context.Oradores.Add(novoOrador);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoOrador.Id_Orador }, novoOrador);
        }

        // PUT: api/oradores/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Oradores oradorAtualizado)
        {
            var orador = _context.Oradores.Find(id);
            if (orador == null) return NotFound();

            orador.Nome = oradorAtualizado.Nome;
            orador.Nif = oradorAtualizado.Nif;
            orador.Email = oradorAtualizado.Email;
            orador.Telefone = oradorAtualizado.Telefone;

            _context.SaveChanges();
            return NoContent();
        }

        // DELETE: api/oradores/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var orador = _context.Oradores.Find(id);
            if (orador == null) return NotFound();

            _context.Oradores.Remove(orador);
            _context.SaveChanges();

            return NoContent();
        }
    }
}