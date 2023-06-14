local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return{
s({trig="-fm", dscr="expand markdown yaml front metter",snippetType="autosnippet"},
  fmt( -- The snippet code actually looks like the equation environment it produces.
    [===[
    ---
    title: <>
    date: <>
    tags: ["<>"]
    --- 
    
    ## Mnemonic

    ## Contents

    <>
    ]===],
    -- The insert node is placed in the <> angle brackets
    { f(function(_) local slug = vim.api.nvim_buf_get_name(0) return string.match(slug,".+/(.+)%.%a+") end) ,
      f(function(_)  return  os.date("%Y-%m-%d")   end),
      i(1),
      i(2)},
    -- This is where I specify that angle brackets are used as node positions.
    { delimiters = "<>" }
  )
),
s({trig="<ref", dscr="expand markdown yaml front metter",snippetType="autosnippet"},
  fmt( -- The snippet code actually looks like the equation environment it produces.
    [===[
    ## Refenrences
    - <>
    ]===],
    -- The insert node is placed in the <> angle brackets
    { 
     
      i(1),
      },
    -- This is where I specify that angle brackets are used as node positions.
    { delimiters = "<>" }
  )
),

s({trig="<mne", dscr="expand markdown mnemonic heading",snippetType="autosnippet"},
  fmt( -- The snippet code actually looks like the equation environment it produces.
    [===[
    ## mnemonic
    - <>
    ]===],
    -- The insert node is placed in the <> angle brackets
    {
      i(1),
      },
    -- This is where I specify that angle brackets are used as node positions.
    { delimiters = "<>" }
  )
)
}
