def stock_picker(arr)
   diff = {}
   arr.each_with_index do |sell_price, sell_idx|
      arr.each_with_index do |buy_price, buy_idx|
        if sell_price > buy_price && sell_idx > buy_idx
           diff[sell_price - buy_price] = [buy_idx, sell_idx]
        end
      end
   end
   diff[diff.keys.max]
end

p stock_picker([17,3,6,9,15,8,2])