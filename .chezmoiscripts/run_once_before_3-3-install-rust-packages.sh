#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_3-3-install-rust-packages.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*isntall-rust-packages* | true | '*' | 1) exit ;;
esac

if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source "${HOME}"/.cargo/env
fi

case "$(uname -s)" in
Darwin)
  if command -v port >/dev/null 2>&1; then
    # There are known issues with Macports libiconv for Rust packages.
    sudo port -q deactivate -f libiconv >/dev/null 2>&1

    reenable-libiconv() {
      sudo port -q activate libiconv >/dev/null 2>&1
    }

    trap reenable-libiconv EXIT
  fi
  ;;
esac

install-package() {
  local -a args pre
  local i
  for i in "$@"; do
    case "${i}" in
    --) break ;;
    +*) pre=("${pre[@]}" "${i}") ;;
    *) args=("${args[@]}" "${i}") ;;
    esac
  done

  cargo "${pre[@]}" install --quiet "${args[@]}" && printf "."
}

install-package shellharden -- A corrective bash syntax highlighter
install-package ag -- CLI App to slice and dice logfiles
install-package atuin -- atuin - magical shell history
install-package bat -- A cat clone with wings
install-package cargo-audit -- Audit Cargo.lock security vulnerabilities
install-package cargo-authors -- A cargo subcommand that lists all the authors of all dependencies
install-package cargo-benchcmp -- A cargo utility to compare Rust micro-benchmark output
install-package cargo-bump -- Increments the version number of the current project
install-package cargo-cli -- Create a command line interface binary with some common dependencies
install-package cargo-clone -- A cargo subcommand to fetch the source code of a Rust crate
install-package cargo-config -- cargo-config reads information from a Cargo.toml file on the command line
install-package cargo-crates -- A cargo command to quickly open the crates.io or docs.rs page
install-package cargo-ctags -- analyze dependencies and generate single TAGS
install-package cargo-deadlinks -- Cargo subcommand to check documentation broken links
install-package cargo-do -- A Cargo plugin that allows multiple chained commands
install-package cargo-edit -- Extends Cargo to allow adding and removing dependencies
install-package cargo-expand -- Wrapper around rustc -Zunpretty=expanded
install-package cargo-license -- Cargo subcommand to see license of dependencies
install-package cargo-lichking -- Display info about licensing of dependencies
install-package cargo-modules -- A cargo plugin to show a tree-like overview of a modules
install-package cargo-outdated -- Cargo subcommand to display when dependencies are out of date
install-package cargo-readme -- A cargo subcommand to generate README.md content from doc comments
install-package cargo-release -- Cargo subcommand that smooths the release process
install-package cargo-show -- Prints package metadata like pip show, apt-cache show, npm view, gem query, etc
install-package cargo-update -- A cargo subcommand to check and apply updates to installed executables
install-package cargo-watch -- Watches over your project source
install-package committed -- Nitpicking commit history since beabf39
install-package cpc -- evaluates math expressions, with unit conversion support
install-package diffr -- An LCS based diff highlighting tool to ease code review from your terminal.
install-package difftastic -- A structural diff that understands syntax
install-package dotenv-linter -- Lightning-fast .env file linter
install-package drill -- Drill is a HTTP load testing application
install-package du-dust -- A more intuitive version of du
install-package dua-cli -- A tool to conveniently learn about the disk usage of directories, fast
install-package dum -- An npm scripts runner
install-package eva -- Calculator REPL similar to bc
install-package exa -- A modern ls replacement
install-package fastmod -- Fast, partial codemod replacement
install-package fd-find -- fd is a simple, fast and user-friendly alternative to find
install-package fnm -- Fast and simple Node.js version manager
install-package fselect -- Find files with SQL-like queries
install-package git-absorb -- git commit --fixup, but automatic
install-package git-brws -- Command line tool to open a repository on a hub
install-package git-historian -- Git Historian allows you to collect arbitrary data about a file
install-package git-journal -- The Git Commit Message and Changelog Generation Framework
install-package git-stack -- Stacked branch management
install-package gitui -- blazing fast terminal-ui
install-package gobang --version 0.1.0-alpha.5 -- A cross-platform TUI database management tool
install-package gping -- Ping, but with a graph
install-package grex -- grex generates regular expressions from user-provided test cases
install-package hexyl -- A command-line hex viewer
install-package ht -- Yet another HTTPie clone
install-package htmlq -- Like jq but HTML
install-package huniq -- Filter out duplicates on the command line
install-package hyperfine -- A command-line benchmarking tool
install-package jless -- A command-line JSON viewer
install-package just -- Just a command runner
install-package loc -- Count lines of code fast
install-package mdcat -- Terminal Markdown formatter
install-package mrml-cli -- MJML renderer CLI
install-package navi -- An interactive cheatsheet tool
install-package procs -- A modern ps replacement
install-package rage -- A simple, secure, and modern encryption tool
install-package ripgrep -- ripgrep is a line-oriented search tool
install-package rm-improved -- rip: a safe and ergonomic alternative to rm
install-package rnr -- rename multiple files and directories
install-package scryer-prolog -- A modern Prolog implementation
install-package sd -- An intuitive find and replace CLI
install-package skim -- Fuzzy Finder
install-package stringsext -- find multi-byte-encoded strings
install-package svgbob_cli -- Transform your ascii diagrams into happy little SVG
install-package taplo-cli -- A Taplo TOML toolkit CLI
install-package tealdeer -- Fetch and show tldr help CLI command pages
install-package tidy-viewer -- CSV file head utility
install-package titlecase -- A tool and library that capitalizes text according to a style
install-package tokei -- Count your code quickly
install-package toml-fmt -- Format toml files
install-package typos-cli -- Source Code Spelling Correction
install-package watchexec-cli -- Executes commands on file modification
install-package xcp -- partial improved clone of cp
install-package xh -- Friendly and fast HTTP request tool
install-package xsv -- A high performance CSV command line toolkit
install-package ytop -- A TUI system monitor written
install-package zellij -- A terminal workspace with batteries included
install-package zoxide -- A smarter interactive cd command

printf "\n"