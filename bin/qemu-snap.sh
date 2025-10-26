#!/usr/bin/env bash

# Script para gerenciar snapshots de imagens QCOW2 com qemu-img

read -rp "Informe o caminho da imagem qcow2: " qcow2

# Verifica se o arquivo existe
if [[ ! -f "$qcow2" ]]; then
    echo "Erro: arquivo não encontrado!"
    exit 1
fi

echo
echo "=== Snapshots existentes em $qcow2 ==="
qemu-img snapshot -l "$qcow2" || echo "Nenhuma snapshot encontrada."

echo
read -rp "Deseja criar uma nova snapshot? (s/n): " criar
if [[ "$criar" == "s" ]]; then
    read -rp "Nome da nova snapshot: " nome
    if [[ -n "$nome" ]]; then
        qemu-img snapshot -c "$nome" "$qcow2"
        echo "Snapshot '$nome' criada com sucesso."
    else
        echo "Nome inválido, não foi criada nenhuma snapshot."
    fi
fi

echo
read -rp "Deseja deletar alguma snapshot anterior? (s/n): " deletar
if [[ "$deletar" == "s" ]]; then
    echo "Snapshots disponíveis:"
    qemu-img snapshot -l "$qcow2" | awk 'NR>2 {print NR-2") "$2}'
    echo
    read -rp "Informe o nome da snapshot a deletar: " alvo
    if [[ -n "$alvo" ]]; then
        qemu-img snapshot -d "$alvo" "$qcow2"
        echo "Snapshot '$alvo' removida."
    else
        echo "Nenhuma snapshot deletada."
    fi
fi

echo
echo "=== Situação final das snapshots ==="
qemu-img snapshot -l "$qcow2"
