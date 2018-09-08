unit LudoCustomUnit;

interface

uses
  SysUtils;

procedure SortArray(var nums: array of integer);

  implementation

procedure SortArray(var nums: array of integer);
// Bubblesort
var
  changed: boolean;
  i: integer;
  tmp: integer;
begin
  changed := True;
  while (changed = True) do
  begin
    changed := False;
    for i := 1 to length(nums) - 1 do
    begin
      if nums[i - 1] > nums[i] then
      begin
        tmp := nums[i - 1];
        nums[i - 1] := nums[i];
        nums[i] := tmp;
        changed := True;
      end;
    end;
  end;
end;

end.
