using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Collections.Generic;
using System.Linq;
using GestaoEventosAPI.Data;
using System;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UtilizadorController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UtilizadorController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/utilizador
        [HttpGet]
        public ActionResult<List<Utilizador>> Get()
        {
            return Ok(_context.Utilizador.ToList());
        }

        // GET: api/utilizador/{id}
        [HttpGet("{id}")]
        public ActionResult<Utilizador> Get(int id)
        {
            var utilizador = _context.Utilizador.Find(id);
            if (utilizador == null) return NotFound();

            return Ok(utilizador);
        }

        // POST: api/utilizador
        [HttpPost]
        public ActionResult Post([FromBody] Utilizador novoUtilizador)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _context.Utilizador.Add(novoUtilizador);
                _context.SaveChanges();

                return CreatedAtAction(nameof(Get), new { id = novoUtilizador.Id_Utilizador }, novoUtilizador);
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao criar utilizador: {ex.Message}");
            }
        }

        // PUT: api/utilizador/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] Utilizador utilizadorAtualizado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var utilizador = _context.Utilizador.Find(id);
            if (utilizador == null) return NotFound();

            try
            {
                utilizador.Nome = utilizadorAtualizado.Nome;
                utilizador.Email = utilizadorAtualizado.Email;
                utilizador.Telemovel = utilizadorAtualizado.Telemovel;
                utilizador.Data_Nascimento = utilizadorAtualizado.Data_Nascimento;
                utilizador.passe = utilizadorAtualizado.passe;

                _context.SaveChanges();

                return Ok(utilizador);
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao atualizar utilizador: {ex.Message}");
            }
        }

        // DELETE: api/utilizador/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var utilizador = _context.Utilizador.Find(id);
            if (utilizador == null) return NotFound();

            try
            {
                _context.Utilizador.Remove(utilizador);
                _context.SaveChanges();

                return NoContent();
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao eliminar utilizador: {ex.Message}");
            }
        }
    }
}
