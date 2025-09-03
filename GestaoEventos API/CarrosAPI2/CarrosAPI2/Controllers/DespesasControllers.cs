using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DespesasController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Despesas> Despesa = new List<Despesas>();

        public DespesasController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<List<Despesas>> Get()
        {
            return Ok(_context.Despesas.ToList());
        }

         // GET: api/despesas/{id}
        [HttpGet("{id}")]
        public ActionResult<Despesas> Get(int id)
        {
            var Despesas = _context.Despesas.Find(id);
            if (Despesas == null) return NotFound();

            return Ok(Despesa);
        }

        // POST: api/despesas
        [HttpPost]
        public ActionResult Post(Despesas novaDespesas)
        {
            _context.Despesas.Add(novaDespesas);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novaDespesas.Id_Despesas }, novaDespesas);
        }

        // PUT: api/despesas/{id}
        [HttpPut("{id}")]
        public ActionResult<Despesas> PutDespesas(int id, Despesas despesaAtualizada)
        {
            var despesa = _context.Despesas.FirstOrDefault(l => l.Id_Despesas == id);
            if (despesa == null) return NotFound();

            despesa.Descricao = despesaAtualizada.Descricao;
            despesa.Id_Evento = despesaAtualizada.Id_Evento;
            despesa.Id_Orador = despesaAtualizada.Id_Orador;
            despesa.Id_Staff = despesaAtualizada.Id_Staff;

            _context.SaveChanges();

            return NoContent();
        }

        // DELETE: api/despesas/{id}
        [HttpDelete("{id}")]
        public ActionResult DeleteDespesas(int id)
        {
            var despesa = _context.Despesas.Find(id);
            if (despesa == null) return NotFound();

            _context.Despesas.Remove(despesa);
            _context.SaveChanges();

            return NoContent();
        }
    }
}