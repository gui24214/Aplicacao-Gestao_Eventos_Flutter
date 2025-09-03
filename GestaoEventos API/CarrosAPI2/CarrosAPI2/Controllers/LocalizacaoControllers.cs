using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LocalizacaoController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Localizacao> localizacao = new List<Localizacao>();

        public LocalizacaoController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/localizacao
        [HttpGet]
        public ActionResult<List<Localizacao>> Get()
        {
            return Ok(_context.Localizacao);
        }

        // GET: api/localizacao/{id}
        [HttpGet("{id}")]
        public ActionResult<Localizacao> Get(int id)
        {
            var localizacao = _context.Localizacao.Find(id);
            if (localizacao == null) return NotFound();
            return Ok(localizacao);
        }

        // POST: api/localizacao
        [HttpPost]
        public ActionResult<Localizacao> Post(Localizacao novaLocalizacao)
        {
            _context.Localizacao.Add(novaLocalizacao);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novaLocalizacao.Id_Localizacao }, novaLocalizacao);
        }

        // PUT: api/localizacao/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Localizacao localizacaoAtualizada)
        {
            var localizacao = _context.Localizacao.Find(id);
            if (localizacao == null) return NotFound();

            localizacao.Morada = localizacaoAtualizada.Morada;
            localizacao.Codigo_Postal = localizacaoAtualizada.Codigo_Postal;

            _context.SaveChanges();

            return NoContent();
        }

        // DELETE: api/localizacao/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var localizacao = _context.Localizacao.Find(id);
            if (localizacao == null) return NotFound();

            _context.Localizacao.Remove(localizacao);
            _context.SaveChanges();

            return NoContent();
        }
    }
}