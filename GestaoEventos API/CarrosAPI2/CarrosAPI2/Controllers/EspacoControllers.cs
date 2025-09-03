using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EspacoController : ControllerBase
    {
        private readonly AppDbContext _context;
        
        private static List<Espaco> espacos = new List<Espaco>();

        public EspacoController (AppDbContext context)
        {
            _context = context;
        }

        // GET: api/espaco
        [HttpGet]
        public ActionResult<List<Espaco>> Get()
        {
            return Ok(_context.Espaco);
        }

        // GET: api/espaco/{id}
        [HttpGet("{id}")]
        public ActionResult<Espaco> Get(int id)
        {
            var espaco = espacos.FirstOrDefault(e => e.Id_Espaco == id);
            if (espaco == null) return NotFound();
            return Ok(espaco);
        }

        // POST: api/espaco
        [HttpPost]
        public ActionResult Post(Espaco novoEspaco)
        {
            _context.Espaco.Add(novoEspaco);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoEspaco.Id_Espaco }, novoEspaco);
        }


        // PUT: api/espaco/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Espaco espacoAtualizado)
        {
            var espaco = espacos.FirstOrDefault(e => e.Id_Espaco == id);
            if (espaco == null) return NotFound();

            espaco.Nome = espacoAtualizado.Nome;

            return NoContent();
        }

        // DELETE: api/espaco/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var espaco = espacos.FirstOrDefault(e => e.Id_Espaco == id);
            if (espaco == null) return NotFound();

            espacos.Remove(espaco);
            return NoContent();
        }
    }
}
