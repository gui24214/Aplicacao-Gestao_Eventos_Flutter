using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestaoEventosAPI.Models
{
    public class Despesas
    {
        [Key] //define a chave primaria
        public int Id_Despesas { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings

        public string Descricao { get; set; }

        public decimal Valor { get; set; }

        public int Id_Evento { get; set; }

        public int Id_Orador { get; set; }

        public int Id_Staff { get; set; }

        [ForeignKey("Id_Evento")]
        public Evento Evento { get; set; }

        [ForeignKey("Id_Orador")]
        public Oradores Oradores { get; set; }

        [ForeignKey("Id_Staff")]
        public Staff Staff { get; set; }






    }
}