%% TEST for the laplacian:
%		This script executes two functions to calcualte regularization
%		matrices.
%		
%		surface Laplacian calculates an approximation of the surface first
%		and second derivative operators and then computes a Laplacian
%		matrix from the former.
%
%		3D Laplacian computes a similar set of matrices, although in this
%		case the operators take into account euclidean distances instead of
%		the geometry provided by the mesh.
%
%		INPUT:
%			- heart - struct - heart geometry:
%								heart.node - <3,M>double - positions of the
%									nodes of the geometry.
%								heart.face - <3,F>double - triplets of the
%									surface triangles.
%


%% surface Laplacian
	[D,Dtan,H,Htan] = meshsurfdiffhessmatrix(heart,meshnormalvectors(heart));
	Ltan=LaplacianMatrixFromHessianMatrix(Htan);


%% Estimate the 3D laplacian

[D] = PairwiseDistance(heart.node);

% choose sigma
sigma = (sort(D));
sigma = max(sigma,[],2);
sigma = sigma(3);

[wghFcn] = invExplonentialWeight(heart, sigma, 0);

[cDf cHf] = meshVolDiffHessMatrix(heart,wghFcn);
