using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TipoEventoController : ControllerBase
    {
        private readonly AppDbContext _context;
        
        private static List<Tipo_Evento> tipoEvento = new List<Tipo_Evento>();

        public TipoEventoController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/tipoevento
        [HttpGet]
        public ActionResult<List<Tipo_Evento>> Get()
        {
            return Ok(_context.Tipo_Evento);
        }

        // GET: api/tipoevento/{id}
        [HttpGet("{id}")]
        public ActionResult<Tipo_Evento> Get(int id)
        {
            var tipo = tipoEvento.FirstOrDefault(te => te.Id_Tipo_Evento == id);
            if (tipo == null) return NotFound();
            return Ok(tipo);
        }

        // POST: api/tipoevento
        [HttpPost]
        public ActionResult Post(Tipo_Evento novoTipo)
        {
            novoTipo.Id_Tipo_Evento = tipoEvento.Count > 0 ? tipoEvento.Max(te => te.Id_Tipo_Evento) + 1 : 1;
            tipoEvento.Add(novoTipo);
            return CreatedAtAction(nameof(Get), new { id = novoTipo.Id_Tipo_Evento }, novoTipo);
        }

        // PUT: api/tipoevento/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Tipo_Evento tipoAtualizado)
        {
            var tipo = tipoEvento.FirstOrDefault(te => te.Id_Tipo_Evento == id);
            if (tipo == null) return NotFound();

            tipo.Nome = tipoAtualizado.Nome;
            return NoContent();
        }

        // DELETE: api/tipoevento/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var tipo = tipoEvento.FirstOrDefault(te => te.Id_Tipo_Evento == id);
            if (tipo == null) return NotFound();

            tipoEvento.Remove(tipo);
            return NoContent();
        }
    }
}
