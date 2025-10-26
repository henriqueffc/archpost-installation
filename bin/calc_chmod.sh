#!/bin/bash

# Função para converter permissões em número
perm_value() {
    local r=$1
    local w=$2
    local x=$3
    local val=0
    [[ $r == "y" ]] && ((val+=4))
    [[ $w == "y" ]] && ((val+=2))
    [[ $x == "y" ]] && ((val+=1))
    echo $val
}

echo "=== Calculadora de chmod (modo numérico) ==="
echo "Digite 'y' para sim e 'n' para não."

# Permissões para Usuário
echo "Permissões para o Dono (owner):"
read -p "  Leitura (r)? " o_r
read -p "  Escrita (w)? " o_w
read -p "  Execução (x)? " o_x

# Permissões para Grupo
echo "Permissões para o Grupo:"
read -p "  Leitura (r)? " g_r
read -p "  Escrita (w)? " g_w
read -p "  Execução (x)? " g_x

# Permissões para Outros
echo "Permissões para Outros:"
read -p "  Leitura (r)? " u_r
read -p "  Escrita (w)? " u_w
read -p "  Execução (x)? " u_x

# Calcula os valores
owner_val=$(perm_value $o_r $o_w $o_x)
group_val=$(perm_value $g_r $g_w $g_x)
other_val=$(perm_value $u_r $u_w $u_x)

# Exibe resultado
chmod_val="${owner_val}${group_val}${other_val}"
echo ""
echo "Comando chmod correspondente: chmod $chmod_val"
