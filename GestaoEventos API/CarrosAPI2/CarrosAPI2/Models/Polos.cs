using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestaoEventosAPI.Models
{
    [Table("Polos")]
    public class Polos
    {
        [Key] //define a chave primaria
        public int Id_Polo { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Nome_Polo { get; set; }

        public int Id_Espaco { get; set; }
        public int Id_Localizacao { get; set; }

        // Propriedades de navegação
        [ForeignKey("Id_Espaco")]
        public Espaco Espaco { get; set; }

        [ForeignKey("Id_Localizacao")]
        public Localizacao Localizacao { get; set; }


    }
}
