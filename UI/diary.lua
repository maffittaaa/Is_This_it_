currentPage = 1

function DrawDiary()
    if drawOpenDiary == false then
        diarySprite = love.graphics.newImage("Sprites/diary.png")
        love.graphics.draw(diarySprite, camera.x + 655, camera.y + 320)
        love.graphics.rectangle("line", camera.x + 722, camera.y + 415, 15, 15)
        love.graphics.print("R", camera.x + 725, camera.y + 415)
    end
end

function DrawFirstPage()
    currentPage = 1
    diarySprite = love.graphics.newImage("Sprites/diary_opened.png")
    love.graphics.draw(diarySprite, camera.x - 510, camera.y - 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x - 445, camera.y - 170)
    love.graphics.print("I found this book with empty pages so I \ndecided to write my story here!", camera.x - 445,
        camera.y - 105)
    love.graphics.print("I can’t write today's date here because \ntime in this place is different.", camera.x - 445,
        camera.y - 35)
    love.graphics.print("The only thing that I know is that when it \ngets dark I need to run and hide.", camera.x - 445,
        camera.y + 30)
    love.graphics.print("Page 1", camera.x - 445, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end

function DrawSecondPage()
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
    love.graphics.print(
        "Today I discovered some shocking \nthings about this place... and a key near \nsome trees but I don't know what unlocks",
        camera.x + 50, camera.y - 105)
    love.graphics.print("But I can't write what it is right now \nbecause I think I'm being followed.", camera.x + 50,
        camera.y - 10)
    love.graphics.print("I'm telling you later, got to go!", camera.x + 50, camera.y + 60)
    love.graphics.print("Page 2", camera.x + 400, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end

function DrawThirdPage()
    currentPage = 3
    diarySprite = love.graphics.newImage("Sprites/diary_opened.png")
    love.graphics.draw(diarySprite, camera.x - 510, camera.y - 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("PAGE MISSING", camera.x - 325, camera.y - 25)
    love.graphics.setColor(1, 1, 1)
    if collectiblePages.counter == 1 then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
        love.graphics.print("I found out that there is another world called earth \nbeyond this one", camera.x - 445,
            camera.y - 105)
        love.graphics.print("At the moment we are in afterlife, but there is a way out!", camera.x - 445, camera.y - 35)
        love.graphics.print("I need to go, but I'll \ntell you more later", camera.x - 445, camera.y + 30)
        love.graphics.print("Page 3", camera.x - 445, camera.y + 210)
        love.graphics.setColor(1, 1, 1)
    end
end

function DrawForthPage()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("PAGE MISSING", camera.x + 185, camera.y - 25)
    love.graphics.setColor(1, 1, 1)
    if collectiblePages.counter == 2 then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
        love.graphics.print("The way out of this world is \ninside a castle hidden in a basement", camera.x + 50,
            camera.y - 105)
        love.graphics.print("I'm passing the bridge to the dark \nforest but our friends seem strange...", camera.x + 50,
            camera.y - 10)
        love.graphics.print("I hope I can find the castle", camera.x + 50, camera.y + 60)
        love.graphics.print("Page 4", camera.x + 400, camera.y + 210)
        love.graphics.setColor(1, 1, 1)
    end
end

function DrawFifthPage()
    currentPage = 5
    diarySprite = love.graphics.newImage("Sprites/diary_opened.png")
    love.graphics.draw(diarySprite, camera.x - 510, camera.y - 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x - 445, camera.y - 170)
    love.graphics.print("I'm sorry I didn't write on you this past \ndays...", camera.x - 445, camera.y - 105)
    love.graphics.print("When I mentioned that in the last entry, \nthey started attacking me.", camera.x - 445,
        camera.y - 35)
    love.graphics.print("But I escaped, and now I'm hiding in \nthe dark forest", camera.x - 445, camera.y + 30)
    love.graphics.print("Page 5", camera.x - 445, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end

function DrawSixthPage()
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
    love.graphics.print("I managed to escape the dark forest \nbut I couldn't find it...", camera.x + 50,
        camera.y - 105)
    love.graphics.print("Maybe next time I leave this cabin I \ncan figure it out", camera.x + 50, camera.y - 35)
    love.graphics.print("Talk to you soon", camera.x + 50, camera.y + 30)
    love.graphics.print("Page 6", camera.x + 400, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end

function DrawSeventhPage()
    currentPage = 7
    diarySprite = love.graphics.newImage("Sprites/diary_opened.png")
    love.graphics.draw(diarySprite, camera.x - 510, camera.y - 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("PAGE MISSING", camera.x - 325, camera.y - 25)
    love.graphics.setColor(1, 1, 1)
    if collectiblePages.counter == 3 then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
        love.graphics.print("The key that I discovered earlier \nis for the basement of the castle", camera.x - 445,
            camera.y - 105)
        love.graphics.print("I'm preparing everything to \ngo out again and explore", camera.x - 445, camera.y - 35)
        love.graphics.print("We need to get to earth, they say it's so pretty...", camera.x - 445, camera.y + 30)
        love.graphics.print("Page 7", camera.x - 445, camera.y + 210)
        love.graphics.setColor(1, 1, 1)
    end
end

function DrawPageEight()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("PAGE MISSING", camera.x + 185, camera.y - 25)
    love.graphics.setColor(1, 1, 1)
    if collectiblePages.counter == 4 then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
        love.graphics.print("Everything is ready for me to go out", camera.x + 50, camera.y - 105)
        love.graphics.print("I'm passing that bridge again, but \nthis time I'm prepared for them!", camera.x + 50,
            camera.y - 10)
        love.graphics.print("See you soon!", camera.x + 50, camera.y + 60)
        love.graphics.print("Page 8", camera.x + 400, camera.y + 210)
        love.graphics.setColor(1, 1, 1)
    end
end

function DrawPageNine()
    currentPage = 9
    diarySprite = love.graphics.newImage("Sprites/diary_opened.png")
    love.graphics.draw(diarySprite, camera.x - 510, camera.y - 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x - 445, camera.y - 170)
    love.graphics.print("I found it!", camera.x - 445, camera.y - 105)
    love.graphics.print("I'm going to enter the last step now ", camera.x - 445, camera.y - 45)
    love.graphics.print("I hope I can make it in time to get out of here", camera.x - 445, camera.y + 10)
    love.graphics.print("I'll see you soon", camera.x - 445, camera.y + 70)
    love.graphics.print("Page 9", camera.x - 445, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end

function DrawPageTen()
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print("Dear Diary, ", camera.x + 50, camera.y - 170)
    love.graphics.print("I couldn't make it in time...", camera.x + 50, camera.y - 105)
    love.graphics.print("I'm going to leave you in the cabin \nso someone else can read you", camera.x + 50,
        camera.y - 45)
    love.graphics.print("It's getting dark, I can't see anything...", camera.x + 50, camera.y + 30)
    love.graphics.print("Page 10", camera.x + 400, camera.y + 210)
    love.graphics.setColor(1, 1, 1)
end
