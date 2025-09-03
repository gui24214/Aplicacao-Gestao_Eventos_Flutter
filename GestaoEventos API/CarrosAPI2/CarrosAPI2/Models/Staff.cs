using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestaoEventosAPI.Models
{
    [Table("Staff")]
    public class Staff
    {
        [Key] //define a chave primaria
        public int Id_Staff { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Nome { get; set; }

        public int Id_Estatuto { get; set; }

        public int Id_Evento { get; set; }

        [ForeignKey("Id_Estatuto")]
        public Estatuto Estatuto { get; set; }

        [ForeignKey("Id_Evento")]
        public Evento Evento { get; set; }


    }
}
       

