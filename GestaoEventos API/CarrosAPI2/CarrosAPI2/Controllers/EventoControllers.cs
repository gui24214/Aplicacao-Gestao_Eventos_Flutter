using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using System.Linq;
using GestaoEventosAPI.Data;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EventoController : ControllerBase
    {
        private readonly AppDbContext _context;

        private static List<Evento> Evento = new List<Evento>();

        public EventoController(AppDbContext context)
        {
            _context = context;
        }

        // Método GET: Retorna todos os eventos
        [HttpGet]
        public ActionResult<List<Evento>> Get()
        {
            return Ok(_context.Evento);
        }

        // Método GET: Retorna um evento por ID
        [HttpGet("{id}")]
        public ActionResult<Evento> Get(int id)
        {
            var Evento = _context.Evento.Find(id);
            if (Evento == null) return NotFound();

            return Ok(Evento);
        }

        // Método POST: Cria um novo evento
        [HttpPost]
        public ActionResult Post(Evento novoEvento)
        {
            _context.Evento.Add(novoEvento);
            _context.SaveChanges();

            return CreatedAtAction(nameof(Get), new { id = novoEvento.Id_Evento }, novoEvento);
        }

        // Método PUT: Atualiza um evento existente
        [HttpPut("{id}")]
        public ActionResult Put(int id, Evento eventoAtualizado)
        {
            var evento = _context.Evento.FirstOrDefault(e => e.Id_Evento == id);
            if (evento == null) return NotFound();

            // Atualizar os campos
            evento.Nome = eventoAtualizado.Nome;
            evento.Hora_Inicio = eventoAtualizado.Hora_Inicio;
            evento.Hora_Fim = eventoAtualizado.Hora_Fim;
            evento.Data = eventoAtualizado.Data;
            evento.Capacidade_Maxima = eventoAtualizado.Capacidade_Maxima;
            evento.Id_Tipo_Evento = eventoAtualizado.Id_Tipo_Evento;
            evento.Id_Orador = eventoAtualizado.Id_Orador;
            evento.Id_Staff = eventoAtualizado.Id_Staff;
            evento.Id_Espaco = eventoAtualizado.Id_Espaco;
            evento.Id_Polo = eventoAtualizado.Id_Polo;

            // Salvar as alterações no banco
            _context.SaveChanges();
            return NoContent();
        }

        // Método DELETE: Exclui um evento por ID
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var evento = _context.Evento.Find(id);
            if (evento == null) return NotFound();

            _context.Evento.Remove(evento);
            _context.SaveChanges();

            return NoContent();
        }
    }
}