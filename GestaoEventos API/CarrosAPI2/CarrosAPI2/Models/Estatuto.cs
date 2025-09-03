using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Estatuto
    {
        [Key] //define a chave primaria
        public int Id_Estatuto { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Nome { get; set; }
    }
}
