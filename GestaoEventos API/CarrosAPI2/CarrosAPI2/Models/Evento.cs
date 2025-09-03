using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestaoEventosAPI.Models
{
    public class Evento
    {
        [Key] //define a chave primaria
        public int Id_Evento { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Nome { get; set; }

        public DateTime Hora_Inicio { get; set; }
        public DateTime Hora_Fim { get; set; }

        public DateTime Data { get; set; }

        public int Capacidade_Maxima { get; set; }

        public int Id_Tipo_Evento { get; set; }

        public int Id_Orador { get; set; }

        public int Id_Staff { get; set; }

        public int Id_Espaco { get; set; }

        public int Id_Polo{ get; set; }

        [ForeignKey("Id_Tipo_Evento")]
        public Tipo_Evento Tipo_Evento { get; set; }

        [ForeignKey("Id_Orador")]
        public Oradores Oradores { get; set; }

        [ForeignKey("Id_Espaco")]
        public Espaco Espaco { get; set; }

        [ForeignKey("Id_Staff")]
        public Staff Staff { get; set; }

        [ForeignKey("Id_Polo")]
        public Polos Polos { get; set; }




    }
}
