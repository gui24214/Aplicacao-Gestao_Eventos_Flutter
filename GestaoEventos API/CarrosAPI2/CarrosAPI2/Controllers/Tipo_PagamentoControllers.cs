using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using GestaoEventosAPI.Data;
using System.Collections.Generic;
using System.Linq;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TipoPagamentoController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TipoPagamentoController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<List<Tipo_Pagamento>> Get()
        {
            var tipos = _context.Tipo_Pagamento.ToList();
            return Ok(tipos);
        }

        [HttpGet("{id}")]
        public ActionResult<Tipo_Pagamento> Get(int id)
        {
            var tipo = _context.Tipo_Pagamento.Find(id);
            if (tipo == null) return NotFound();
            return Ok(tipo);
        }

        [HttpPost]
        public ActionResult Post(Tipo_Pagamento novoTipo)
        {
            _context.Tipo_Pagamento.Add(novoTipo);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoTipo.Id_Tipo_Pagamento }, novoTipo);
        }

        [HttpPut("{id}")]
        public ActionResult Put(int id, Tipo_Pagamento tipoAtualizado)
        {
            var tipo = _context.Tipo_Pagamento.Find(id);
            if (tipo == null) return NotFound();

            tipo.Categoria = tipoAtualizado.Categoria;
            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var tipo = _context.Tipo_Pagamento.Find(id);
            if (tipo == null) return NotFound();

            _context.Tipo_Pagamento.Remove(tipo);
            _context.SaveChanges();

            return NoContent();
        }
    }
}
