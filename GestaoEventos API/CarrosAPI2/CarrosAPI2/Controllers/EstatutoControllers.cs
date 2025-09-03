using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstatutoController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Estatuto> estatuto = new List<Estatuto>();

        public EstatutoController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/estatuto
        [HttpGet]
        public ActionResult<List<Estatuto>> Get()
        {
            return Ok(_context.Estatuto.ToList());
        }

        // GET: api/estatuto/{id}
        [HttpGet("{id}")]
        public ActionResult<Estatuto> Get(int id)
        {
            var estatuto = _context.Estatuto.Find(id);
            if (estatuto == null) return NotFound();

            return Ok(estatuto);
        }

        // POST: api/estatuto
        [HttpPost]
        public ActionResult Post(Estatuto novoEstatuto)
        {
            _context.Estatuto.Add(novoEstatuto);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoEstatuto.Id_Estatuto }, novoEstatuto);
        }

        // PUT: api/estatuto/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, Estatuto estatutoAtualizado)
        {
            var estatuto = _context.Estatuto.Find(id);
            if (estatuto == null) return NotFound();

            estatuto.Nome = estatutoAtualizado.Nome;

            _context.SaveChanges();
            return NoContent();
        }

        // DELETE: api/estatuto/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var estatuto = _context.Estatuto.Find(id);
            if (estatuto == null) return NotFound();

            _context.Estatuto.Remove(estatuto);
            _context.SaveChanges();

            return NoContent();
        }
    }
}