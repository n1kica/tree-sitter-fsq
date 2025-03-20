#!/bin/zsh

# Ensure script stops on any error
set -e

# Step 1: Generate Tree-sitter files
tree-sitter generate

# Step 2: Run Tree-sitter tests
tree-sitter test

# Step 3: Compile parser.so
cc -shared -fPIC -I./src src/parser.c src/scanner.c -o sql.so

# Step 4: Move the generated parser.so to the desired location
mv ~/trees/tree-sitter-fsq/sql.so ~/.local/share/nvim/lazy/nvim-treesitter/parser/sql.so

# Step 5: Copy highlight groups highlights.scm to the desired location
cp ~/trees/tree-sitter-fsq/queries/highlights.scm ~/.local/share/nvim/lazy/nvim-treesitter/queries/sql/highlights.scm
cp ~/trees/tree-sitter-fsq/queries/indents.scm ~/.local/share/nvim/lazy/nvim-treesitter/queries/sql/indents.scm

