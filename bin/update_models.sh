#!/bin/bash

# Script para atualizar modelos do Ollama
# Uso: ./atualizar_ollama.sh [modelo1 modelo2 ...]

echo "🚀 Iniciando atualização de modelos Ollama..."

# Verifica se o Ollama está instalado
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama não está instalado. Por favor, instale o Ollama primeiro."
    exit 1
fi

# Função para atualizar um modelo específico
atualizar_modelo() {
    modelo=$1
    echo "🔄 Atualizando modelo: $modelo"
    ollama pull $modelo
    if [ $? -eq 0 ]; then
        echo "✅ Modelo $modelo atualizado com sucesso!"
    else
        echo "❌ Erro ao atualizar o modelo $modelo"
    fi
    echo ""
}

# Se modelos foram especificados como argumentos, atualiza apenas esses
if [ $# -gt 0 ]; then
    echo "📋 Atualizando modelos especificados: $@"
    for modelo in "$@"; do
        atualizar_modelo $modelo
    done
else
    # Caso contrário, detecta e atualiza todos os modelos instalados
    echo "🔍 Detectando modelos instalados..."
    modelos=$(ollama list | tail -n +2 | awk '{print $1}')
    
    if [ -z "$modelos" ]; then
        echo "⚠️ Nenhum modelo encontrado!"
        exit 1
    fi
    
    echo "📋 Modelos encontrados:"
    echo "$modelos"
    echo ""
    
    for modelo in $modelos; do
        atualizar_modelo $modelo
    done
fi

echo "🎉 Processo de atualização concluído!"
