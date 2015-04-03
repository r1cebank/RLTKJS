require 'rltk/lexer'

module JS
  class Lexer < RLTK::Lexer
    # whitespace
    rule(/\s/)
    rule(/\t/)
    rule(/<script type="text\/JavaScript">/)
    rule(/<\/script>/)

    # keywords
    rule(/var/) {  :VAR  }
    rule(/document.write/) {  :DOCW  }

    # operators and delimiters.
		rule(/\(/)	{ :LPAREN }
		rule(/\)/)	{ :RPAREN }
    rule(/\n/)  { :ENDL   }
		rule(/;/)		{ :SEMI   }
    rule(/:/)   { :COLON  }
		rule(/,/)		{ :COMMA  }
		rule(/\+/)	{ :PLUS   }
		rule(/-/)		{ :SUB    }
		rule(/\*/)	{ :MUL    }
		rule(/\//)	{ :DIV    }
    rule(/=/)   { :EQ     }
    rule(/\./)  { :DOT    }

    # identifier
    rule(/[A-Za-z][A-Za-z0-9]*/) { |t| [:ID, t] }

    # numeric rules.
    rule(/\d+/)		{ |t| [:NUMBER, t.to_f] }
		#rule(/\.\d+/)		{ |t| [:NUMBER, t.to_f] }
		#rule(/\d+\.\d+/)	{ |t| [:NUMBER, t.to_f] }

    # string rules.
    rule(/"[^"^\n]*"/) { |t| [:STRING, t.to_s]}

    # comment rules.
		rule(/#/)				{ push_state :comment }
		rule(/\n/, :comment)	{ pop_state }
		rule(/./, :comment)
  end
end