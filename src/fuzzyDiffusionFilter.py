import constants
import numpy as np
from sklearn.neighbors import KDTree

class fuzzyDiffusionFilter:
    def __init__(self, image, pathToMembershipFunction):
        self.image = image
        self.pathToMembershipFunction = pathToMembershipFunction 
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
        self.GxMask = constants.GXMASK
        self.GyMask = constants.GYMASK

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

    
    def addBoundary(self):
        self.image = np.pad(self.image,int(self.horizon),mode='symmetric')
        self.Nx = self.Nx + 2*int(self.horizon)
        self.Ny = self.Ny + 2*int(self.horizon)

    def loadMembershipFunction(self):
        self.membershipFunction = np.loadtxt(self.pathToMembershipFunction, delimiter=",")
        
    def assignMembership(self):
        pixelMemberships = []
        for iCol in range(self.Nx):
            for iRow in range(self.Ny):
                currentPixelMembership = []
                currentPixelMembership.append(self.image[iCol,iRow])
                currentPixelMembership.append(list(self.membershipFunction[int(self.image[iCol,iRow])])[0])
                currentPixelMembership.append(list(self.membershipFunction[int(self.image[iCol,iRow])])[1])
                pixelMemberships.append(currentPixelMembership)
        self.pixelMemberships = pixelMemberships

    def createFuzzyMembershipImage(self):
        fuzzyMembershipImage = []
        for iPixel in range(self.Nx*self.Ny):
            fuzzyMembershipImage.append(self.pixelMemberships[iPixel][1])
        self.fuzzyMembershipImage = np.array(fuzzyMembershipImage).reshape((self.Nx,self.Ny))

    def calculateFuzzyDerivatives(self):
        Dx = []
        Dy = []
        for iCol in range(1,self.Nx-1):
            for iRow in range(1,self.Ny-1):
                Gx = np.multiply(self.GxMask,self.fuzzyMembershipImage[iRow-int(self.horizon):iRow+int(self.horizon)+1,iCol-int(self.horizon):iCol+int(self.horizon)+1])
                Gy = np.multiply(self.GyMask,self.fuzzyMembershipImage[iRow-int(self.horizon):iRow+int(self.horizon)+1,iCol-int(self.horizon):iCol+int(self.horizon)+1])
                Dxi = (Gx[2][2]+Gx[2][1]+Gx[2][0])-(Gx[0][2]+Gx[0][1]+Gx[0][0])
                Dyi = (Gy[2][2]+Gy[1][2]+Gy[0][2])-(Gy[2][0]+Gy[1][0]+Gy[0][0])
                Dx.append(Dxi)
                Dy.append(Dyi)
        self.Dx = Dx
        self.Dy = Dy


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

    def thresholdLocalSmoothness(self):
        localSmoothness = np.array(self.localSmoothness)
        localSmoothness[localSmoothness<0.35] = 0
        localSmoothness[localSmoothness != 0] = 1
        self.localSmoothness = list(localSmoothness)

    def timeIntegrate(self):
        timeSteps = int(self.finalTime/self.dt)
        timeSteps = 1000
        for iTimeStep in range(timeSteps+1):
            print(iTimeStep)
            noisyImage = self.image
            self.addBoundary()
            self.assignMembership()
            self.createFuzzyMembershipImage()
            self.calculateFuzzyDerivatives()
            np.savetxt('../data/Dx.csv',  self.Dx, delimiter=",")
            np.savetxt('../data/Dy.csv',  self.Dy, delimiter=",")
            print('Here')
            a = input('').split(" ")[0]
            self.createSimilarityMatrices()
            self.calculateLocalAndGeneralSmoothness()
            self.thresholdLocalSmoothness()
            #noisyImage = noisyImage + list(np.array(self.gradient) * self.lambd*self.dt)
            #self.image = noisyImage
            #if iTimeStep%10 == 0:
                #np.savetxt('..\\data\\localSmoothness'+str(iTimeStep)+'.csv',  self.localSmoothness, delimiter=",")
            np.savetxt('../data/localSmoothness'+str(iTimeStep)+'.csv',  self.localSmoothness, delimiter=",")
            a = input('').split(" ")[0]
        self.denoisedImage = noisyImage

    def solve(self):
        self.createPDDOKernelMesh()
        self.findNeighboringPixels()
        self.loadMembershipFunction()
        self.timeIntegrate()
        #a = input('').split(" ")[0]
