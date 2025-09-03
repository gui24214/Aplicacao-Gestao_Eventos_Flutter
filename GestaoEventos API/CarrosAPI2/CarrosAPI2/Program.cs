using Microsoft.EntityFrameworkCore;
using GestaoEventosAPI.Data;

var builder = WebApplication.CreateBuilder(args);

// ⬇️ Registra o AppDbContext com a connection string
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrWhiteSpace(connectionString))
{
    throw new InvalidOperationException("Connection string 'DefaultConnection' não foi encontrada no appsettings.json.");
}

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(connectionString));

// Serviços
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod());
});

// Configuração do servidor Kestrel
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5294); // Porta customizada
});

var app = builder.Build();

// Swagger no ambiente de desenvolvimento
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Pipeline
app.UseHttpsRedirection(); // 👍 Redireciona para HTTPS se aplicável
app.UseCors("AllowAll");

// app.UseAuthentication(); // Ative se usar autenticação
app.UseAuthorization();

app.MapControllers();

app.Run();
