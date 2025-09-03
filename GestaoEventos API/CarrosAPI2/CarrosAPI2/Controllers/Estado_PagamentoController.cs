using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstadoController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Estado_Pagamento> estado_Pagamentos = new List<Estado_Pagamento>();

        public EstadoController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<List<Estado_Pagamento>> Get()
        {
            return Ok(_context.Estado_Pagamento.ToList());
        }

        [HttpGet("{id}")]
        public ActionResult<Estado_Pagamento> Get(int id)
        {
            var estado = _context.Estado_Pagamento.FirstOrDefault(e => e.Id_Estado == id);
            if (estado == null) return NotFound();
            return Ok(estado);
        }

        [HttpPost]
        public ActionResult Post(Estado_Pagamento novoEstado)
        {
            _context.Estado_Pagamento.Add(novoEstado);
            _context.SaveChanges();
            return CreatedAtAction(nameof(Get), new { id = novoEstado.Id_Estado }, novoEstado);
        }

        [HttpPut("{id}")]
        public ActionResult Put(int id, Estado_Pagamento estadoAtualizado)
        {
            var estado = _context.Estado_Pagamento.FirstOrDefault(e => e.Id_Estado == id);
            if (estado == null) return NotFound();

            estado.Descricao = estadoAtualizado.Descricao;

            _context.SaveChanges();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var estado = _context.Estado_Pagamento.FirstOrDefault(e => e.Id_Estado == id);
            if (estado == null) return NotFound();

            _context.Estado_Pagamento.Remove(estado);
            _context.SaveChanges();
            return NoContent();
        }
    }
}
