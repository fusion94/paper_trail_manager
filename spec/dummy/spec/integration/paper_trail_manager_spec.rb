require 'spec_helper'

describe PaperTrailManager do
  include Capybara

  def version
    return assigns[:version]
  end

  def versions
    return assigns[:versions]
  end

  def item_types
    return versions.map(&:item_type).uniq.sort
  end

  def populate
      @reimu = FactoryGirl.create(:entity, :name => "Miko Hakurei Reimu", :status => "Highly Responsive to Prayers")
      @reimu.update_attributes(:name => "Hakurei Reimu", :status => "Phantasmagoria of Dimensional Dream")
      @reimu.update_attributes(:status => "Perfect Cherry Blossom")

      @sakuya = FactoryGirl.create(:entity, :name => "Sakuya Izayoi", :status => "Flowering Night")

      @flanchan = FactoryGirl.create(:entity, :name => "Flandre Scarlet", :status => "The Embodiment of Scarlet Devil")
      @flanchan.destroy

      @kyuu_hachi = FactoryGirl.create(:platform, :name => "PC-9801", :status => "SUGOI!!1!")
      @kyuu_hachi.update_attributes(:status => "Kimochi warui.")
      @kyuu_hachi.destroy

      @uinodouzu = FactoryGirl.create(:platform, :name => "Mikorusofto Uinodouzu", :status => 'o-O')
  end

  context "without changes" do
    context "index" do
      it "should have no changes by default" do
        get "/changes"

        assigns[:versions].should be_empty
      end
    end
  end

  context "with changes" do
    before(:all) do
      populate
    end

    after(:all) do
      Entity.destroy_all
      Platform.destroy_all
      Version.destroy_all
    end

    context "index" do
      context "when getting all changes" do
        context "and authorized" do
          before(:all) { get changes_path }

          it "should have all changes" do
            versions.size.should == 10
          end

          it "should have changes for all changed item types" do
            item_types.should == ["Entity", "Platform"]
          end

          it "should order changes with newest and highest id at the top" do
            versions.map(&:id).should == versions.sort_by { |o| [o.created_at, o.id] }.reverse.map(&:id)
          end
        end

        context "when not authorized" do
          it "should display an error if user is not allowed to list changes"
        end
      end

      context "when getting changes for a specific type" do
        context "that exists" do
          before(:all) { get changes_path(:type => "Entity") }

          it "should show a subset of the changes" do
            versions.size.should == 6
          end

          it "should have changes only for that type" do
            item_types.should == ["Entity"]
          end
        end

        context "that doesn't exist" do
          it "should display ana error that the type doesn't exist"
        end
      end

      context "when getting changes for a specific record" do
        context "that exists" do
          before(:all) { get changes_path(:type => "Entity", :id => @reimu.id) }

          it "should show a subset of the changes" do
            versions.size.should == 3
          end

          it "should have changes only for that type" do
            item_types.should == ["Entity"]
          end

          it "should have changes only for that record" do
            versions.map(&:item_id).uniq.should == [@reimu.id]
          end
        end

        context "that doesn't exist" do
          it "should display an error that the record doesn't exist"
        end
      end
    end

    context "show a change" do
      context "that exists" do
        context "when authorized" do
          before(:all) do
            @version = @reimu.versions.last
            get change_path(@version)
          end

          it "should show the requested change" do
            version.should == @version
          end

          it "should show a change with the right event" do
            version.event.should == "update"
          end

          it "should be associated with the expected record" do
            version.item.should == @reimu
          end
        end

        context "when not authorized" do
          it "should display an error if user is not allowed to show the change"
        end
      end

      context "that doesn't exist" do
        it "should display an error that the change doesn't exist"
      end
    end
  end

  context "when rolling back changes" do
    context "that that exist" do
      before(:each) { populate }

      context "when authorized" do
        it "should rollback a newly-created record by deleting it" do
          Entity.exists?(@reimu.id).should be_true

          put change_path(@reimu.versions.first)

          Entity.exists?(@reimu.id).should be_false
        end

        it "should rollback an edit by reverting to the previous state" do
          @reimu.reload
          @reimu.status.should == "Perfect Cherry Blossom"

          put change_path(@reimu.versions.last)

          @reimu.reload
          @reimu.status.should == "Phantasmagoria of Dimensional Dream"
        end

        it "should rollback a delete by restoring the record" do
          Entity.exists?(@flanchan.id).should be_false

          put change_path(Version.where(:item_id => @flanchan.id, :item_type => "Entity").last)

          flanchan = Entity.find(@flanchan.id)
          flanchan.status.should == "The Embodiment of Scarlet Devil"
        end
      end

      context "when not authorized" do
          it "should display an error if user is not allowed to revert that change"
      end
    end

    context "that don't exist" do
      it "should display an error that the change doesn't exist"
    end
  end
end
