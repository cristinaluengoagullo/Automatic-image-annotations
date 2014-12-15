% Function to extract the coordinates of the manually annotated pixels in
% each area of interest.
%   idCard: IDCard structure holding the information about pixel
%   coordinates
%   [pskys,...,ppeds] = Matrices holding the positions of the pixels in
%   each area
function [pskys,pvegs,pbricks,proofs,pwindows,pdoors,ppeds] = regions_points(idCard)
    pskys = idCard.IDCard.skys.pointsCoordinates;
    pvegs = idCard.IDCard.vegetations.pointsCoordinates;
    pbricks = idCard.IDCard.bricksOrConcretes.pointsCoordinates;
    proofs = idCard.IDCard.roofs.pointsCoordinates;
    pwindows = idCard.IDCard.windowpanes.pointsCoordinates;
    pdoors = idCard.IDCard.doors.pointsCoordinates;
    ppeds = idCard.IDCard.pedestrians.pointsCoordinates;
end