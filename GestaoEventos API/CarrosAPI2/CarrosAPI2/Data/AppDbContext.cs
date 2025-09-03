using GestaoEventosAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace GestaoEventosAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Tipo_Evento> Tipo_Evento { get; set; }
        public DbSet<Estado_Pagamento> Estado_Pagamento { get; set; }
        public DbSet<Tipo_Pagamento> Tipo_Pagamento { get; set; }
        public DbSet<Espaco> Espaco { get; set; }
        public DbSet<Localizacao> Localizacao { get; set; }
        public DbSet<Polos> Polos { get; set; }
        public DbSet<Oradores> Oradores { get; set; }
        public DbSet<Utilizador> Utilizador { get; set; }
        public DbSet<Estatuto> Estatuto { get; set; }
        public DbSet<Staff> Staff { get; set; }
        public DbSet<Despesas> Despesas { get; set; }
        public DbSet<Evento> Evento { get; set; }
        public DbSet<Inscricao> Inscricao { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Desabilita uso da cláusula OUTPUT para evitar erro com triggers no SQL Server
            modelBuilder.Entity<Utilizador>()
                .Metadata.SetAnnotation("SqlServer:UseOutputClause", false);
        }
    }
}
