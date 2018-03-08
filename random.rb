module Jekyll
   module RandomFilter

      def random_number(x, min=0, max=100, round=0)
         value = ((x * Math::PI * Math::E * max + (Math.sin(x/max) * max)) % (max - min)) + min
         if round != 0
           value = (('%.' + round.to_s + 'f') % value).to_f
         else
           value = value.round
         end

         value
      end

   end
end

Liquid::Template.register_filter(Jekyll::RandomFilter)