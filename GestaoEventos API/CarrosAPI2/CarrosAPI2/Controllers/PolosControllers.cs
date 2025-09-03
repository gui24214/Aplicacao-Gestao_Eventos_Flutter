using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PoloController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Polos> Polos = new List<Polos>();

        public PoloController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/polo
        [HttpGet]
        public ActionResult<List<Polos>> Get()
        {
            return Ok(_context.Polos.ToList());
        }

        // GET: api/polo/{id}
        [HttpGet("{id}")]
        public ActionResult<Polos> Get(int id)
        {
            var polo = _context.Polos.Find(id);
            if (polo == null) return NotFound();

            return Ok(polo);
        }

        // POST: api/polo
        [HttpPost]
        public ActionResult Post(Polos novoPolo)
        {
            _context.Polos.Add(novoPolo);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoPolo.Id_Polo }, novoPolo);
        }

        // PUT: api/polo/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Polos poloAtualizado)
        {
            var polo = _context.Polos.Find(id);
            if (polo == null) return NotFound();

            polo.Nome_Polo = poloAtualizado.Nome_Polo;
            polo.Id_Espaco = poloAtualizado.Id_Espaco;
            polo.Id_Localizacao = poloAtualizado.Id_Localizacao;

            _context.SaveChanges();
            return NoContent();
        }

        // DELETE: api/polo/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var polo = _context.Polos.Find(id);
            if (polo == null) return NotFound();

            _context.Polos.Remove(polo);
            _context.SaveChanges();

            return NoContent();
        }
    }
}