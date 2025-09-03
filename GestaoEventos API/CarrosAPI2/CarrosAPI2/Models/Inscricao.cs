using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestaoEventosAPI.Models
{
    public class Inscricao
    {
        [Key]
        public int Id_Inscricao { get; set; }

        [Required]
        public DateTime Data_Inscricao { get; set; }

        [Required]
        public int Id_Estado { get; set; }

        [Required]
        public int Id_Tipo_Pagamento { get; set; }

        [Required]
        public int Id_Evento { get; set; }

        [Required]
        public int Id_Utilizador { get; set; }

        // Propriedades de navegação opcionais (nullable)
        [ForeignKey("Id_Estado")]
        public virtual Estado_Pagamento? Estado_Pagamento { get; set; }

        [ForeignKey("Id_Tipo_Pagamento")]
        public virtual Tipo_Pagamento? Tipo_Pagamento { get; set; }

        [ForeignKey("Id_Evento")]
        public virtual Evento? Evento { get; set; }

        [ForeignKey("Id_Utilizador")]
        public virtual Utilizador? Utilizador { get; set; }
    }
}
