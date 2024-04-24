import constants
import numpy as np
from sklearn.neighbors import KDTree

class fuzzyDiffusionFilter:
    def __init__(self, image):
        self.image = image.flatten().astype(int)
        self.l1 = constants.L1
        self.l2 = constants.L2
        self.Nx = constants.NX
        self.Ny = constants.NY
        self.dx = self.l1/self.Nx
        self.dy = self.l2/self.Ny
        self.horizon = constants.HORIZON
        self.Dn = constants.Dn
        self.q = constants.q
        self.finalTime = constants.FINALTIME
        self.dt = constants.DELTAT
        self.lambd = constants.LAMBDA

    def createPDDOKernelMesh(self):
        indexing = 'xy'
        xCoords = np.arange(self.dx/2, self.Nx*self.dx, self.dx)
        yCoords = np.arange(self.dy/2, self.Ny*self.dy, self.dy)
        xCoords, yCoords = np.meshgrid(xCoords, yCoords, indexing=indexing)
        xCoords = xCoords.reshape(-1, 1)
        yCoords = yCoords.reshape(-1, 1)
        self.coordinateMesh = np.array([xCoords[:,0], yCoords[:,0]]).T 

    def findNeighboringPixels(self):
        tree = KDTree(self.coordinateMesh, leaf_size=2)
        self.neighboringPixels = tree.query_radius(self.coordinateMesh, r = self.dx*self.horizon)

    
    def createSimilarityMatrices(self):
        similarityMatrices = []
        for currentPixel in range(self.Nx*self.Ny):
            similarityMatrices.append(np.exp(-np.power(np.absolute(self.image[self.neighboringPixels[currentPixel]]-self.image[currentPixel]),self.q)/self.Dn))
        self.similarityMatrices = similarityMatrices

    def calculateLocalAndGeneralSmoothness(self):
        localSmoothness = []
        generalAverage = []
        for currentSimilarityMatrix in range(self.Nx*self.Ny):
            localSmoothness.append((np.sum(self.similarityMatrices[currentSimilarityMatrix])-1)/(len(self.similarityMatrices[currentSimilarityMatrix])-1))
            generalAverage.append(np.average(self.similarityMatrices[currentSimilarityMatrix]))
        self.localSmoothness = localSmoothness
        self.generalAverage = generalAverage

    def calculateLocalGradients(self):
        gradient = []
        for currentPixel in range(self.Nx*self.Ny):
            currentPixelGradients = []
            similarity = []
            for iNeighbor in range(len(self.neighboringPixels[currentPixel])):
                if iNeighbor != currentPixel:
                    similarity.append(self.similarityMatrices[currentPixel][iNeighbor])
                    currentPixelGradients.append(self.image[self.neighboringPixels[currentPixel][iNeighbor]])
            gradient.append(np.dot(similarity,currentPixelGradients))
        self.gradient = gradient

    def timeIntegrate(self):
        timeSteps = int(self.finalTime/self.dt)
        for iTimeStep in range(timeSteps+1):
            print(iTimeStep)
            noisyImage = self.image
            self.createSimilarityMatrices()
            self.calculateLocalAndGeneralSmoothness()
            self.calculateLocalGradients()
            noisyImage = noisyImage + list(np.array(self.gradient) * self.lambd*self.dt)
            self.image = noisyImage
            if iTimeStep%20 == 0:
                np.savetxt('..\\data\\denoisedImages'+str(iTimeStep)+'.csv',  noisyImage, delimiter=",")
        self.denoisedImage = noisyImage

    def solve(self):
        self.createPDDOKernelMesh()
        self.findNeighboringPixels()
        self.timeIntegrate()
        #a = input('').split(" ")[0]
