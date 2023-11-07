require "./gilded_rose.rb"

RSpec.describe GildedRose do
  let(:quality) { rand(-100..100) }
  let(:sell_in) { rand(-100..100) }

  before do
    described_class.new([item]).update_quality
  end

  context "with an unknown item" do
    let(:item) { Item.new("Unknown", sell_in, quality) }

    it "reduces the sell_in by 1" do
      expect(item.sell_in).to eq sell_in - 1
    end

    context "when the sell_in is less than 1" do
      let(:sell_in) { rand(-100..0) }

      context "when quality is greater than 0" do
        let(:quality) { rand(1..100) }

        it "subtracts the quality by 2" do
          expect(item.quality).to eq quality - 2
        end
      end

      context "when quality is less than 0" do
        let(:quality) { rand(-100..-1) }

        it "does nothing to the quality" do
          expect(item.quality).to eq quality
        end
      end
    end

    context "when the sell_in is greater than 0" do
      let(:sell_in) { rand(1..100) }

      context "when the quality is less than 0" do
        let(:quality) { rand(-100..-1) }

        it "the quality remains the same" do
          expect(item.quality).to eq quality
        end
      end

      context "when the quality is greater than 0" do
        let(:quality) { rand(1..100) }

        it "subtracts the quality by 1" do
          expect(item.quality).to eq quality - 1
        end
      end
    end
  end

  context "with aged brie" do
    let(:item) { Item.new("Aged Brie", sell_in, quality) }

    it "reduces the sell_in by 1" do
      expect(item.sell_in).to eq sell_in - 1
    end

    context "when quality is less than 50" do
      let(:quality) { rand(-100..49) }

      context "when sell_in is negative" do
        let(:sell_in) { rand(-100..-1) }

        it "adds 2 to the quality" do
          expect(item.quality).to eq quality + 2
        end
      end

      context "when sell_in is positive" do
        let(:sell_in) { rand(1..100) }

        it "adds 1 to the quality" do
          expect(item.quality).to eq quality + 1
        end
      end
    end

    context "when quality is above 50" do
      let(:quality) { rand(50..100) }

      context "when sell_in is negative" do
        let(:sell_in) { rand(-100..-1) }

        it "does not change the quality" do
          expect(item.quality).to eq quality
        end
      end

      context "when sell_in is positive" do
        let(:sell_in) { rand(1..100) }

        it "does not change the quality" do
          expect(item.quality).to eq quality
        end
      end
    end
  end

  context "when item is a backstage pass" do
    let(:item) do
      Item.new(
        "Backstage passes to a TAFKAL80ETC concert",
        sell_in,
        quality
      )
    end

    context "when the quality is less than 50" do
      let(:quality) { rand(-100..49) }

      context "when sell_in is less than 11 but greater than 6" do
        let(:sell_in) { rand(6..10) }

        it "adds 2 to the quality" do
          expect(item.quality).to eq quality + 2
        end
      end

      context "when sell_in is less than 6 but greater than 0" do
        let(:sell_in) { rand(1..5) }

        it "adds 3 to the quality" do
          expect(item.quality).to eq quality + 3
        end
      end

      context "when the sell_in is less than 1" do
        let(:sell_in) { rand(-100..0) }

        it "reduces the quality to 0" do
          expect(item.quality).to eq 0
        end
      end
    end

    context "when quality is 49" do
      let(:quality) { 49 }

     context "when sell_in is less than 0" do
       let(:sell_in) { rand(-100..-1) }

       it "reduces the quality to 0" do
         expect(item.quality).to eq 0
       end
     end

     context "when the sell_in is greater than 0" do
       let(:sell_in) { rand(1..100) }

       it "increases quality by 1" do
         expect(item.quality).to eq quality + 1
       end
     end

    end

    context "when the quality is greater than 50" do
      let(:quality) { rand(50..100) }

      context "sell_in is 0 or less" do
        let(:sell_in) { rand(-100..0) }

        it "reduces the quality to 0" do
          expect(item.quality).to eq 0
        end
      end

      context "sell_in is greater than 0" do
        let(:sell_in) { rand(1..100) }

        it "reduces the sell_in by 1" do
          expect(item.sell_in).to eq sell_in - 1
        end
      end
    end
  end

  context "with sulfuras" do
    let(:item) do
      Item.new(
        "Sulfuras, Hand of Ragnaros",
        sell_in,
        quality
      )
    end
    let(:quality) { rand(-100..100) }
    let(:sell_in) { rand(-100..100) }

    it "does not change the quality" do
      expect(item.quality).to eq quality
    end

    it "does not change the sell_in" do
      expect(item.sell_in).to eq sell_in
    end
  end
end
