module Jekyll
   module RandomFilter

      def random_number(value, max=100, min=0, offset=0, round=0)
         formatter = round ? '%.' + round.to_s + 'f' : '%'
         value = formatter % ((Math.sin(Math.sin(value + offset)) + 1) * ((max - min) / 2) + min)

         value
      end

   end
end

Liquid::Template.register_filter(Jekyll::RandomFilter)