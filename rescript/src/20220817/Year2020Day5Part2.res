let puzzleInput =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.puzzleInput.txt")->Js.String2.split("\n")

// puzzleInput->Js.log
// TODO:
// 1. seatNumber로 배열을 모두 바꾼다
// 2. 오름차순 sorting한다.
// 3. snd - fst 의 값이 1이 아닌 애를 filter한다.
// 4. 3에서 얻은 값의 fst + 1 또는 snd - 1 이 missing seatNumber

open Belt
exception Invalid_List

let rec getMissingSeatNum = seatList => {
  switch seatList {
  | list{} => raise(Invalid_List)
  | list{seat} => seat + 1
  | list{fst, snd, ...restSeatList} =>
    if snd - fst == 1 {
      getMissingSeatNum(Belt.List.concat(list{snd}, restSeatList))
    } else {
      fst + 1
    }
  }
}

puzzleInput
->Year2020Day5Part1.getSeatIdsFromInput
->SortArray.stableSortBy((a, b) => a - b)
->List.fromArray
->getMissingSeatNum
->Js.log
