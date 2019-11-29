require "jekyll"

module Jekyll
   module RandomFilter

      def random_number(x, min=0, max=100, round=0)
         value = ((x * x * Math::PI * Math::E * (max + 1) * (Math.sin(x) / Math.cos(x * x)) ) % (max + 1 - min)) + min

         value = value > max ? max : value
         value = value < min ? min : value

         if round != 0
           value = (('%.' + round.to_s + 'f') % value)
         else
           value = value.to_i
         end

         value
      end

      def random_item(x, items)
         index = random_number(x, 0, items.size)

         items[index]
      end

      def random_date(x, start_date=false, end_date=false)
         start_date = start_date ? Time.parse(start_date) : (Time.now - 60*60*24*100)
         end_date = end_date ? Time.parse(end_date) : Time.now

         Time.at(random_number(x, start_date.to_i, end_date.to_i))
      end

      def random_date_ago(x, days_ago=100)
         Date.today.prev_day(random_number(x, 0, days_ago))
	    end
   end
end

Liquid::Template.register_filter(Jekyll::RandomFilter)
